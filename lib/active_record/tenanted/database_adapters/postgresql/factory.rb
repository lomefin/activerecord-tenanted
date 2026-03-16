# frozen_string_literal: true

module ActiveRecord
  module Tenanted
    module DatabaseAdapters
      module PostgreSQL
        # Factory for creating the appropriate PostgreSQL adapter based on strategy
        #
        # The strategy is determined by config:
        # - If `schema_name_pattern` is present → "schema" strategy
        # - Else if database name contains `%{tenant}` → "database" strategy
        # - Otherwise → "schema" strategy using the default schema pattern
        #
        # Strategies:
        # - "schema" (default): Uses schema-based multi-tenancy
        # - "database": Uses database-based multi-tenancy
        class Factory
          def self.new(db_config)
            if db_config.configuration_hash[:schema_name_pattern]
              Schema.new(db_config)
            elsif db_config.database.include?("%{tenant}")
              Database.new(db_config)
            else
              Schema.new(db_config)
            end
          end
        end
      end
    end
  end
end
