class API < Sinatra::Base
    def initialize(ledger:)
        @ledger = ledger
        super() #rest of initialion from Sinatra
    end
end