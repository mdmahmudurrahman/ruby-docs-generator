# frozen_string_literal: true
RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # show 10 slowest specs
  config.profile_examples = 5

  # run specs in random order
  config.order = :random

  Kernel.srand config.seed
end
