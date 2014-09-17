require 'metasploit/model/search/operation/group'

# A union of one or more {Metasploit::Model::Search::Operation::Group::Base#children child operations} from an
# operator's `#operate_on`, should be visited the same as {Metasploit::Model::Search::Group::Base}.
class Metasploit::Model::Search::Operation::Group::Union < Metasploit::Model::Search::Operation::Group::Base
end