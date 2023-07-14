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
[ Introduction](#introduction)
[ Folder Structure](#folder-structure)
[ Administration Dashboard](#administration-dashboard)
[ Route Similarity API](#route-similarity-api)
[Client Mobile Application](#client-mobile-application)
[ Contributors](#introduction)

## Introduction

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

2. Navigate to the API directory
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
### Features

## Contributors
<p>
  :mortar_board: <i>All participants in this project are graduate students in the <a href="https://www.concordia.ca/ginacody/computer-science-software-eng.html">Department of Computer Science and Software Engineering</a> <b>@</b> <a href="https://www.concordia.ca/">Concordia University</a></i> <br> <br>
  
  :woman: <b>Divya Bhagavathiappan Shiva</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>divya.bhagavathiappanshiva@mail.concordia.ca</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/divyabhagavathiappan">@divyabhagavathiappan</a> <br>
  
  :woman: <b>Reethu Navale</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>reethu.navale@mail.concordia.ca</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/reethunavale">@reethunavale</a> <br>

  :woman: <b>Mahsa Sadat Afzali Arani</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>m_afzali93@yahoo.com</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/MahsaAfzali">@MahsaAfzali</a> <br>

  :boy: <b>Mohammad Amin Shamshiri</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>mohammadamin.shamshiri@mail.concordia.ca</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/ma-shamshiri">@ma-shamshiri</a> <br>
</p>

<br>
✤ <i>This was the final project for the course COMP 6321 - Machine Learning (Fall 2020), at <a href="https://www.concordia.ca/">Concordia University</a><i>
