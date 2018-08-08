require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
    RSpec.describe "Expense Tracker API" do
        include Rack::Test::Methods

        def app
            ExpenseTracker::API.new #a class called API in the ExpenseTracker module
        end

        def post_expense(expense) #helper logic
            post '/expenses', JSON.generate(expense)
            expect(last_response.status).to eq(200) #plays the same role as an assertion method

            parsed = JSON.parse(last_response.body)
            expect(parsed).to include('expense_id' => a_kind_of(Integer))
            expense.merge('id' => parsed['expense_id']) #add an id key to the hash from the database
        end

        it 'records submitted expenses' do #JSON objects convert to Ruby hashes with string keys
            pending 'Need to persist expenses'
            coffee = post_expense(
                'payee' => 'Starbucks',
                'amount' => 5.75,
                'date' => '2017-06-10'
            )

            zoo = post_expense(
                'payee' => 'Zoo',
                'amount' => 15.25,
                'date' => '2017-06-10'
            )

            groceries = post_expense(
                'payee' => 'Whole Foods',
                'amount' => 95.20,
                'date' => '2017-06-11'
            )

            get '/expenses/2017-06-10'
            expect(last_response.status).to eq(200)
            expenses = JSON.parse(last_response.body)
            expect(expenses).to contain_exactly(coffee,zoo) #we want to check the array contains two expenses we want

            #post '/expenses', JSON.generate(coffee)
            
            
        
        end      
    end
end