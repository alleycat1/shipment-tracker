# Shipment Tracker
A tool that tracks the locations and shipping details of humanitarian aid sent to Ukraine by Aid Pioneers.

## Dependencies
- `ruby 3.0.3`, best installed via [rbenv](https://github.com/rbenv/rbenv)
- `node 16.13.1`, best installed via [nvm](https://github.com/nvm-sh/nvm)
- [Yarn Version 1](https://classic.yarnpkg.com/en/), `npm install --global yarn`
- `rails 6.1.6` & `bundler 2.3.13`
- [PostgreSQL](https://www.postgresql.org/) or use `docker` to create a containerised instance of postgres, see below.

### Optional
- [Prettier](https://prettier.io/)
- `rubocop 1.30.0`

## Setup
1. Install Ruby dependencies via `bundle install`.
2. Install Javascript dependencies via `yarn install`.
3. Create `.env` file in the root project directory. It should contain:
    - `MAPBOX_API_KEY=<API-KEY-GOES-HERE>` with your own API key from [Mapbox](https://www.mapbox.com/)
    - `SHIPMENT_TRACKER_DATABASE_PASSWORD=<LOCAL-DB-PASSWORD-GOES-HERE>` with the password of the DB being run locally e.g. "password".
4. Make sure PostgreSQL is running. You can do this by installing postgres directly, or using `docker` to create a container via `docker run -p 5432:5432 --name shipment_tracker_db -e POSTGRES_USER=shipment_tracker -e POSTGRES_PASSWORD=password postgres`.
5. Run: `rails db:prepare RAILS_ENV=development`
6. Run dev server using `rails s`

## Running the tests
In order to run the tests, run the following:

```shell
 rails test:all
```

## Useful tips
If you want to debug your local development database then install [psql](https://formulae.brew.sh/formula/postgresql) and run the following command:

```shell
psql postgresql://localhost:5432/shipment_tracker_development -U shipment_tracker
```

and supply the password of "password" when prompted to do so.
