#!/bin/bash

# Comment out line that is causing syntax error when launching container
sed -i -e "s/token: str = ''/#token: str = ''/g" conduit/user/models.py

flask db init
flask db migrate
flask db upgrade

flask run --with-threads
