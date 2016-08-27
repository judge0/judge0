# Judge0API

## Development Setup

1. Change `.env`

2. Build
  ```
  $ docker-compose build
  ```

3. Run `db` service
  ```
  $ docker-compose up -d db
  ```

4. Run `bash` in `backend` service
  ```
  $ docker-compose run -p 3000:3000 backend bash
  ```

5. Create database and run migrations
  ```
  # rails db:create db:migrate
  ```

6. Run Rails server on `0.0.0.0:3000`
  ```
  # rails s -b 0.0.0.0
  ```
