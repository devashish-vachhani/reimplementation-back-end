require 'swagger_helper'
require 'assignment.rb'

RSpec.describe 'api/v1/participants', type: :request do

  path '/api/v1/participants/index/{model}/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'model', in: :path, type: :string, description: 'Assignment'
    parameter name: 'id', in: :path, type: :integer, description: 1


    get('index participants') do
      let(:model) { 'Assignment' }
      let(:id) { 1 }
      let(:assignment) { class_double(Assignment) }
      let(:an_assignment) { instance_double(Assignment) }
      let(:participants_array) { [] }

      before do
        allow(Object).to receive(:const_get).with(model).and_return(assignment)
        allow(Object).to receive(:const_get).and_call_original
        allow(assignment).to receive(:find).with(id).and_return(an_assignment)
        #allow(assignment).to receive(:participants).and_return(participants_array)
        allow(an_assignment).to receive(:participants).and_return(participants_array)
      end
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

  path '/api/v1/participants/{model}/{id}/{authorization}' do
    # You'll want to customize the parameter types...
    parameter name: 'model', in: :path, type: :string, description: 'model'
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

    post('create participant') do
      response(200, 'successful') do
        let(:model) { '123' }
        let(:id) { '123' }
        let(:authorization) { '123' }

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

  path '/api/v1/participants/change_handle/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('update_handle participant') do
      response(200, 'successful') do
        let(:id) { '123' }

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

  path '/api/v1/participants/update_authorizations/{id}/{authorization}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

    post('update_authorizations participant') do
      response(200, 'successful') do
        let(:id) { '123' }
        let(:authorization) { '123' }

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

  path '/api/v1/participants/inherit/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('inherit participant') do
      response(200, 'successful') do
        let(:id) { '123' }

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

  path '/api/v1/participants/bequeath/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('bequeath participant') do
      response(200, 'successful') do
        let(:id) { '123' }

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

  path '/api/v1/participants/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete participant') do
      response(200, 'successful') do
        let(:id) { '123' }

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
