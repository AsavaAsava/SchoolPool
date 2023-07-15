from flask import Flask, request, jsonify
from polyline import decode
from math import radians, sin, cos, sqrt, atan2

app = Flask(__name__)

def haversine_distance(lat1, lon1, lat2, lon2):
    R = 6371  # Radius of the Earth in kilometers

    # Convert latitude and longitude to radians
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])

    # Calculate the differences in coordinates
    dlat = lat2 - lat1
    dlon = lon2 - lon1

    # Apply the Haversine formula
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    distance = R * c

    return distance


def compare_routes(route1, route2):
    total_distance = 0
    total_points = min(len(route1), len(route2))

    for i in range(total_points - 1, -1, -1):  # Iterate from last coordinates to first
        lat1, lon1 = route1[i]
        lat2, lon2 = route2[i]
        distance = haversine_distance(lat1, lon1, lat2, lon2)
        total_distance += distance

    average_distance = total_distance / total_points
    similarity_score = 1 - (average_distance / 100)  # Normalize the score between 0 and 1

    return similarity_score


@app.route('/compare_routes', methods=['POST'])
def compare_routes_handler():
    data = request.json

    polyline1 = data.get('polyline1', '')
    polyline2 = data.get('polyline2', '')

    route1 = decode(polyline1)
    route2 = decode(polyline2)

    similarity = compare_routes(route1[::-1], route2[::-1])  # Reverse the routes

    response = {
        'similarity_score': similarity
    }

    return jsonify(response)


if __name__ == '__main__':
    app.run()
