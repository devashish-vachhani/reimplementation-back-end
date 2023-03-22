require 'swagger_helper'

RSpec.describe 'Roles API', type: :request do

  path '/api/v1/participants/index/Assignment/1' do
    get('index participants') do
      tags 'participants'

      parameter name: :params, in: :body, schema:{
        type: :object,
        properties: {
          'params': {
            type: :object,
            properties: {
                id: { type: :integer },
                model: { type: :string }
            }
          }
        },
        required: [ 'id', 'model']
      }
      produces 'application/json'

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
