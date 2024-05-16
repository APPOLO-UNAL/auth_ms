# Use official Ruby image as the base image
ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim as base

# Set working directory
WORKDIR /rails

# Set environment variables
#ENV RAILS_ENV=production \
#    BUNDLE_WITHOUT=development:test

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Install Gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
COPY . .

# Non-root user for security
RUN useradd -m rails && chown -R rails:rails /rails
USER rails

# Expose port 3000
EXPOSE 3000

# Start the Rails app
CMD ["rails", "server", "-b", "0.0.0.0"]