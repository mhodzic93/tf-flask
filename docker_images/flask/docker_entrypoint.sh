#!/bin/bash

flask db init
flask db migrate
flask db upgrade

flask run --with-threads
