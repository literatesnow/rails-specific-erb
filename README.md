# Specific

Simple Todo application using Ruby on Rails and Bootstrap.

## Requirements

* [Docker](https://www.docker.com/) installed and running.

## Production

1. Building

      ```bash
        $ docker build -t rails-specific-erb .
      ```

1. Running (starts the application on [http://locahost:8080](http://locahost:8080)).

      ```bash
        $ docker run -d -p 8080:3000 rails-specific-erb
      ```

## Development

1. To use the docker container in development, the container needs to have the same user id and group id as the current user. The ``build_dev`` script sets this up automatically.

      ```bash
        $ ./build_dev
      ```

1. Runs the container and starts a shell (instead of the default entry point which is production mode). The application directory is shared into the container with a volume which means all changes to this directory will be reflected inside the container to ``/opt/service``.

      ```bash
        $ ./run_dev
      ```

1. Inside the container, the first steps in development is to set up the database.

      ```bash
        service:/opt/service$ rake db:migrate
      ```

1. Starting the service which runs on [http://localhost:3000](http://localhost:3000).

      ```bash
        service:/opt/service$ rails server
      ```
