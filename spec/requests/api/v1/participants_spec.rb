require 'swagger_helper'
require 'spec_helper'
require 'rails_helper'

# class AssignmentParticipant < ApplicationRecord
# end

# class Participant < ApplicationRecord
#   has_many :assignments
# end

RSpec.describe 'api/v1/participants', type: :request do
  path '/api/v1/participants/index/{model}/{id}' do
    parameter name: 'model', in: :path, type: :string, description: 'Assignment'
    parameter name: 'id', in: :path, type: :integer, description: 1

    get('index participants') do
      let(:model) { 'Assignment' }
      let(:id) { 1 }
      let(:participants_array) {[instance_double(Participant)]}


      before do
        an_assignment = instance_double(Assignment)
        allow(Assignment).to receive(:find).with(id).and_return(an_assignment)
        allow_any_instance_of(Assignment).to receive(:participants).and_return(participants_array)
        allow(an_assignment).to receive(:participants).and_return(participants_array)
      end

      response(200, 'successful') do   
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, model_object: "Assignment", participants:[])
              #example: JSON.parse(response.body, error: "Missing or invalid required parameters")
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/participants/index/{model}/{id}' do
    parameter name: 'model', in: :path, type: :string, description: 'Assignment'
    parameter name: 'id', in: :path, type: :integer, description: 1

    get('index participants') do
      let(:model) { 'Course' }
      let(:id) { 1 }
      let(:participants_array) {[instance_double(Participant)]}


      before do
        a_course = instance_double(Course)
        allow(Course).to receive(:find).with(id).and_return(a_course)
        allow_any_instance_of(Course).to receive(:participants).and_return(participants_array)
        allow(a_course).to receive(:participants).and_return(participants_array)
      end
      response(200, 'successful') do   
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, model_object: "Course", participants:[])
              #example: JSON.parse(response.body, error: "Missing or invalid required parameters")
            }
          }
        end
        run_test!
      end
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
  #       let(:participant_params) { { handle: 'new_handle' } }
  #       let(:participant) { instance_double(AssignmentParticipant) }
  
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  
  #       it 'updates the participant handle' do
  #         expect(AssignmentParticipant).to receive(:find).with(id).and_return(participant)
  #         expect(participant).to receive(:update).with(participant_params).and_return(true)
  #         expect(participant).to receive(:handle).and_return('old_handle')
  
  #         run_test!
  #       end
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
#end
