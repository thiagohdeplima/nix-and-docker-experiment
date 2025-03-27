FROM nixos/nix:latest AS build

WORKDIR /usr/local/src

COPY . .

RUN nix-build

RUN mkdir -p /srv/app
RUN cp -pvr `nix-store -qR result/` /srv/app

FROM busybox

ENV PYTHONPATH "/srv/app/.virtualenv/lib/python3.12/site-packages/"

WORKDIR /srv/app

COPY --from=build /srv/app /nix/store
COPY --from=build /usr/local/src/result /srv/app

CMD ["/srv/app/.virtualenv/bin/gunicorn", "-b 0.0.0.0", "main:app"]
