import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'scripts/shared'
import 'scripts/frontend';

import 'styles/shared'
import 'styles/frontend';
