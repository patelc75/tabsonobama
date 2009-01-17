#!/bin/sh
railroad -a -i -M | dot -Tpng > models.png RAILS_ENV="staging"