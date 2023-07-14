<p align="center">
    <img src="https://github.com/AsavaAsava/SchoolPool-CSP1/blob/Development/school-pool-logo.png"
        height="400">
       
</p>
<p align="center">
    <a href="https://www.python.org/" alt="Python">
        <img src="https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue" /></a>
    <a href="https://laravel.com/" alt="Laravel">
        <img src="https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white" /></a>
    <a href="https://flutter.dev/" alt="Flutter">
        <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" /></a>

</p>

<h1 align="center"> SchoolPool</h1>
<h3 align="center"> A Carpooling Solution for School Children </h3>

## About the Project

In Kenya, heavy traffic is experienced around school zones during peak pick-up and drop-off times. This often leads to congestion around these areas as most schools cannot accomodate this large number of vehicles. The project therefore aims to reduce the number of vehicles accessing the school through carpooling.

## Table of Contents
[ Introduction](#introduction) <br>

[ Folder Structure](#folder-structure)<br>

[ Administration Dashboard](#administration-dashboard)<br>

[ Route Similarity API](#route-similarity-api)<br>

[Client Mobile Application](#client-mobile-application)<br>

[ Contributors](#contributors)

## Introduction

This project is made up of three main components. A mobile app developed using Flutter, an administrator application built with Laravel, and a Flask API for route similarity calculation and matching.

## Folder Structure
```
    .
    │
    ├── route_similarity_algorithm  --> Route Similarity API
    │  ├── app.py
    │  ├── requirements.txt
    ├── school_pool_admin --> Admin Side Web Dashboard
    │  ├── (Laravel Framework Files)
    ├── school_pool_mobile --> Client Side Mobile Application
    │  ├── (Flutter Framework Files)
```

## Administration Dashboard

This has been built using [Laravel](https://laravel.com/) and has made use of [Jetstream](https://jetstream.laravel.com/3.x/introduction.html) and the [AdminLTE template](https://adminlte.io/). The Administrator System also exposes an API at `/api/verify` which verifies a user is authorized to use the platform.

### Installation
These instructions will guide you on how to set up and run the API on your local machine.

Before getting started, make sure you have the following software installed on your machine:

- PHP (>= 8.0.0)
- Composer
- MySQL (or any other laravel-supported database SQL database)

1. Clone the repository:

```bash
   git clone https://github.com/AsavaAsava/SchoolPool-CSP1.git
```

2. Navigate to the Laravel directory
```bash
   cd ./school_pool_admin
```

3. Install Dependencies using Composer

```bash
   composer install
```
4. Create an `.env` file based on the availed example file `.example.env`
```bash
  cp .env.example .env
```
5. Configure the database by filling in the following fields in the `.env` file
```bash 
DB_CONNECTION=
DB_HOST=
DB_PORT=
DB_DATABASE=
DB_USERNAME=
DB_PASSWORD=
```
6. For Password Reset Email Functionalities, connect the application to an Mail Server by filling in the following fields in the `.env` file
```bash
MAIL_MAILER=smtp
MAIL_HOST=
MAIL_PORT=
MAIL_USERNAME=
MAIL_PASSWORD=
MAIL_ENCRYPTION=
MAIL_FROM_ADDRESS=
MAIL_FROM_NAME=
```
7. Generate application key
```bash
php artisan key:generate
```
8. Run database migrations
```bash
php artisan migrate
```
9. (Optional) Seed the database with sample data:
```bash
php artisan db:seed
```
10. Start the development server
```bash
php artisan serve
```

## Route Similarity API
The Route Similarity API is a Flask-based RESTful API that compares the similarity between two routes represented by encoded polylines as recieved from the [Google Maps Routes API](https://cloud.google.com/blog/products/maps-platform/announcing-routes-api-new-enhanced-version-directions-and-distance-matrix-apis). It calculates the similarity score based on the [haversine distance](https://en.wikipedia.org/wiki/Haversine_formula) between corresponding points on the routes.

The Route Matching API is currently hosted [here](https://routingalgorithm-s2eiekt5ja-ew.a.run.app/)  [![lterm](https://img.shields.io/badge/webiste-live-brightgreen.svg?style=flat-square)](https://routingalgorithm-s2eiekt5ja-ew.a.run.app)

### Quick Start
To compare two routes, send a JSON Request containing encoded polylines for the two routes you would like to compare to the `/compare_routes` endpoint of the API.(https://routingalgorithm-s2eiekt5ja-ew.a.run.app/compare_routes)
The JSON Request should have the following format:
```bash
{
  "polyline1": "encoded_polyline_1",
  "polyline2": "encoded_polyline_2"
}
```

The API will respond with a JSON object containing the similarity score as follows:
```bash
{
  "similarity_score": 0.85
}

```
### Installation
These instructions will guide you on how to set up and run the API on your local machine.

#### Prerequisites

- Python 3.6 or higher
- pip package manager

1. Clone the repository:

```bash
   git clone https://github.com/AsavaAsava/SchoolPool-CSP1.git
```

2. Navigate to the API directory
```bash
   cd ./route_similarity_algorithm
```
3. Create and Activate a virtual environment
```bash
python3 -m venv env
source env/bin/activate
```
4. Install the required dependencies
```bash
pip install -r requirements.txt
```
5. Run the flask application
```bash
flask run
```
The API will start running on `http://localhost:5000`
Make a POST request with a JSON Payload to `http://localhost:5000/compare_routes` as described in the [quickstart section](#quick-start)

## Client Mobile Application
The client mobile application is available for [Android](www.android.com).
### Features
1. Ride Scheduling
    The platform allows Drivers to schedule their rides and parents to request for their children to be picked up.
2. Live Location Tracking
    The platform uses the Google Maps API to provide the driver with the most efficient route. The drivers location is tracked and can be viewd by Parents whose children are on the ride during the duration of the trip.
3. Live chat
    Parents can communicate with the driver theough the in-app chat service.
4. Automatic Payment
    Once a ride is complete, the parent's whose children are transported are automatically billed. (Not yet implemented)

## Contributors
<p>
  :mortar_board: <i>All participants in this project are graduate students in the <a href="https://whttps://sces.strathmore.edu/">School of Computing and Engineering Sciences</a> <b>@</b> <a href="https://www.strathmore.edu/">Strathmore University</a></i> <br> <br>
  
   <b>Wayne Asava</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>wayne.asava@strathmore.edu</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/AsavaAsava">@AsavaAsava</a> <br>
  
  <b>Nathan Mbugua</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>nathan.mbugua@strathmore.edu</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/some-casual-coder">@some-casual-coder</a> <br>

</p>

<br>
✤ <i>This was the final project for the course ICS 2204 - CS Project 1, at <a href="https://www.strathmore.edu/">Concordia University</a><i>
