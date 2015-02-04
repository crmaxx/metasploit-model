# Code shared between `Mdm::Author` and `Metasploit::Framework::Author`.
module Metasploit::Model::Author
  extend ActiveModel::Naming
  extend ActiveSupport::Concern

  include Metasploit::Model::Translation

  included do
    include ActiveModel::Validations
    include Metasploit::Model::Search

    #
    # Search Attributes
    #

    search_attribute :name, :type => :string

    #
    # Validations
    #

    validates :name, :presence => true
  end

  #
  # Associations
  #

  # @!attribute [r] email_addresses
  #   Email addresses used by this author across all {#module_instances}.
  #
  #   @return [Array<Metasploit::Model::EmailAddress>]

  # @!attribute [r] module_instances
  #   Modules written by this author.
  #
  #   @return [Array<Metasploit::Model::Module::Instance>]

  #
  # Attributes
  #

  # @!attribute [rw] name
  #   Full name (First + Last name) or handle of author.
  #
  #   @return [String]
end
