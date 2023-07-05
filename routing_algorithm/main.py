import polyline
import numpy as np
from math import radians, sin, cos, sqrt, atan2



points_array = polyline.decode('ipkcFfichVnP@j@BLoFVwM{E?',4)

# print(points_array)

# np.savetxt("./output/driver_route.csv",points_array,delimiter=", ",fmt='% s')

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

    for i in range(total_points):
        lat1, lon1 = route1[i]
        lat2, lon2 = route2[i]
        distance = haversine_distance(lat1, lon1, lat2, lon2)
        total_distance += distance

    average_distance = total_distance / total_points
    similarity_score = 1 - (average_distance / 100)  # Normalize the score between 0 and 1

    return similarity_score


# Test

similarity = compare_routes(points_array, points_array)
print(f"Similarity score: {similarity}")