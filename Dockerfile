FROM elixir:otp-25

ARG OPENAPIWEATHER_API_KEY

# Define the open weather api key
ENV an_env_var=$OPENAPIWEATHER_API_KEY

# Copy the source folder into the Docker image
COPY . .

RUN mix local.hex --force \
    && mix local.rebar --force

# Install dependencies and build Release
RUN rm -Rf _build && \
    mix deps.get && \
    mix Release

EXPOSE 4040

# Run the release build
CMD ["_build/dev/rel/isitstillsnowing_revamp/bin/isitstillsnowing_revamp", "start"]
