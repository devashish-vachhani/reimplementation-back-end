require 'swagger_helper'
require 'spec_helper'
require 'rails_helper'

# class AssignmentParticipant < ApplicationRecord
# end

# class Participant < ApplicationRecord
#   has_many :assignments
# end

RSpec.describe 'api/v1/participants', type: :request do
  # path '/api/v1/participants/index/{model}/{id}' do
  #   parameter name: 'model', in: :path, type: :string, description: 'Assignment'
  #   parameter name: 'id', in: :path, type: :integer, description: 1

  #   get('index participants') do
  #     let(:model) { 'Assignment' }
  #     let(:id) { 1 }
  #     let(:participants_array) {[instance_double(Participant)]}


  #     before do
  #       an_assignment = instance_double(Assignment)
  #       allow(Assignment).to receive(:find).with(id).and_return(an_assignment)
  #       allow_any_instance_of(Assignment).to receive(:participants).and_return(participants_array)
  #       allow(an_assignment).to receive(:participants).and_return(participants_array)
  #     end

  #     response(200, 'successful') do   
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, model_object: "Assignment", participants:[])
  #             #example: JSON.parse(response.body, error: "Missing or invalid required parameters")
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/participants/index/{model}/{id}' do
  #   parameter name: 'model', in: :path, type: :string, description: 'Assignment'
  #   parameter name: 'id', in: :path, type: :integer, description: 1

  #   get('index participants') do
  #     let(:model) { 'Course' }
  #     let(:id) { 1 }
  #     let(:participants_array) {[instance_double(Participant)]}


  #     before do
  #       a_course = instance_double(Course)
  #       allow(Course).to receive(:find).with(id).and_return(a_course)
  #       allow_any_instance_of(Course).to receive(:participants).and_return(participants_array)
  #       allow(a_course).to receive(:participants).and_return(participants_array)
  #     end
  #     response(200, 'successful') do   
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, model_object: "Course", participants:[])
  #             #example: JSON.parse(response.body, error: "Missing or invalid required parameters")
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  path '/api/v1/participants/{model}/{id}/{authorization}' do
    # You'll want to customize the parameter types...
    parameter name: 'model', in: :path, type: :string, description: 'model'
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

    post('create participant') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :check_this, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object }
        }
      }
      response(422, 'successful') do
        let(:model) { 'Assignment' }
        let(:id) { 1 }
        let(:authorization) { '123' }
        let(:name) {"ABCD"}
        let(:check_this) { {user: {name: name}} }
        let(:a_user) { instance_double(User) }
        let(:an_assignment) {instance_double(Assignment)}
        let(:a_participant) {instance_double(Participant)}
        let(:participants_array) {[a_participant]}

        before do
          allow(a_user).to receive(:name).and_return(name)
          allow(a_user).to receive(:id).and_return(23)
          allow(an_assignment).to receive(:id).and_return(1)
          allow(User).to receive(:find_by).with({name: name}).and_return(a_user)
          #allow(Object).to receive(:const_get).with(model).and_return(Assignment)
          allow(Assignment).to receive(:find).with(id).and_return(an_assignment)
          allow(an_assignment).to receive(:participants).and_return(Participant)
          #allow(a_participant).to receive(:user_id).and_return(a_user.id)
          allow(Participant).to receive(:find_by).with({user_id: a_user.id}).and_return(a_participant)
          allow(a_participant).to receive(:present?).and_return(true)
          
        end


        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: "Participant #{name} already exists for this #{model}")
            }
          }
        end
        run_test!
      end
    end
  end

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
end
