require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker 
    RecordResult = Struct.new(:success?, :expense_id, :error_message)
    
    RSpec.describe API do
        include Rack::Test::Methods

        def app
            API.new(ledger: ledger)
        end

        let(:ledger) { instance_double('ExpenseTracker::Ledger')} #instance double of ledger class
        
        describe 'POST /expenses' do
            context 'when the expense is successfully recorded' do
                it 'returns the expense id' do 
                    expense = { 'some' => 'data' }

                    allow(ledger).to receive(:record) #calling the allow method from rspec-mocks
                        .with(expense) #passing down the expense hash
                        .and_return(RecordResult.new(true, 417, nil))

                        post '/expenses', JSON.generate(expense)

                        parsed = JSON.parse(last_response.body)
                        expect(parsed).to include('expense_id' => 417)
                end
                it 'responds with a 200 (OK)' 
            end

            context 'when the expense fails validation' do
            end
                # ... next context will go here...
        end 
    end
end
