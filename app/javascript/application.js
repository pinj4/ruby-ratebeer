// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs


import "@hotwired/turbo-rails";
import "controllers";

import { beers } from "custom/utils";

beers();


import { breweries } from "custom/brewery";

breweries();