require 'yaml/store'

module Flue
  class Metadata
    attr_reader :store, :basefiles

    def initialize
      @store = YAML::Store.new(".meta.yml")
    end

    def update_checksum(basefile)
      store.transaction do
        checksums = store["checksums"] || {}
        checksums[basefile.filename] = basefile.checksum
        store["checksums"] = checksums
      end
    end

  end
end
