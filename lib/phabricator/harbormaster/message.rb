require 'phabricator/conduit_client'

module Phabricator::Harbormaster
  class Message
    attr_accessor :phid, :type
    class InvalidType < StandardError ; end
    
    TYPES = ["pass", "fail", "work"]
    
    def initialize(attrs)
      @phid = attrs[:phid]
      @type = attrs[:type]
      validate!
    end

    def validate!
      if !TYPES.include?(type)
        raise InvalidType, "'#{type}' is an invalid message type.\n" +
                           "Message type must be 1 of [#{TYPES.join(", ")}]"
      end
    end
    
    def send
      response = JSON.parse(Message.client.request(:post, 'harbormaster.sendmessage',
                                                   {
                                                     buildTargetPHID: phid,
                                                     type: type
                                                   }))
    end

    def self.client
      @client ||= Phabricator::ConduitClient.instance
    end
  end
end
