#!/bin/sh
{{APP_START_COMMAND}} &
exec caddy run --config /Caddyfile
