# Use official Ruby image as the base image
ARG RUBY_VERSION=3.3.1
FROM ruby:$RUBY_VERSION-slim as base

# Set working directory
WORKDIR /rails

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  curl \
  libvips \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

# Install dos2unix for file conversion
#RUN apt-get update -qq && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Gems
RUN bundle install

# Copy the application code
COPY . .

# Convert potential text files to LF (adjust the paths if needed)
#RUN find /rails -type f -print0 | xargs -0 dos2unix 

# Non-root user for security
RUN useradd -m rails && chown -R rails:rails /rails

# Expose port 3000
EXPOSE 3000

# Start the Rails app
CMD ["rails", "server", "-b", "0.0.0.0"]
