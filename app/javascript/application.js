// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import "@37signals/lexxy"
import "@rails/actiontext"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()