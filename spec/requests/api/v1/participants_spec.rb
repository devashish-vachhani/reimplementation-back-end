require 'swagger_helper'
require 'assignment.rb'
require 'spec_helper'
require 'rails_helper'

RSpec.describe 'api/v1/participants', type: :request do
  let(:model) { 'Assignment' }
  let(:id) { 1 }
  let(:assignment) { class_double(Assignment) }
  let(:an_assignment) { instance_double(Assignment) }#, id: 1) }
  let(:participant) {class_double(Participant)}
  let(:participants_array) {[]}

  before do
    allow(assignment).to receive(:has_many).with(:participants)
    allow(participant).to receive(:belongs_to).with(:assignment)
    allow(Object).to receive(:const_get).with(model).and_return(Assignment)
    allow(an_assignment).to receive(:participants).and_return(participants_array)
  end

  path '/api/v1/participants/index/{model}/{id}' do
    parameter name: 'model', in: :path, type: :string, description: 'Assignment'
    parameter name: 'id', in: :path, type: :integer, description: 1

    get('index participants') do
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

  # path '/api/v1/participants/{model}/{id}/{authorization}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'model', in: :path, type: :string, description: 'model'
  #   parameter name: 'id', in: :path, type: :string, description: 'id'
  #   parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

  #   post('create participant') do
  #     response(200, 'successful') do
  #       let(:model) { '123' }
  #       let(:id) { '123' }
  #       let(:authorization) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/participants/change_handle/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   post('update_handle participant') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/participants/update_authorizations/{id}/{authorization}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'
  #   parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

  #   post('update_authorizations participant') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #       let(:authorization) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/participants/inherit/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('inherit participant') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/participants/bequeath/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('bequeath participant') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/participants/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   delete('delete participant') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end
