require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :markdown
  config.curl_host = 'localhost:3000'
  config.keep_source_order = true
  config.docs_dir = Rails.root.join("doc")
  config.api_name = "Web Money Documentation"
  config.api_explanation = "Web Money Description"
  # config.curl_headers_to_filter = %w(Host Cookie If-Modified-Since If-None-Match)

  # config.response_headers_to_include = %w(Content-Type Content-Length)

  config.request_body_formatter = proc do |params|
    JSON.pretty_generate(params)
  end
end
  