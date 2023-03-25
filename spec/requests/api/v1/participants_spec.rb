require 'swagger_helper'
require 'spec_helper'
require 'rails_helper'

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

  path '/api/v1/participants/{model}/{id}/{authorization}' do
    # You'll want to customize the parameter types...
    parameter name: 'model', in: :path, type: :string, description: 'model'
    parameter name: 'id', in: :path, type: :integer, description: 'id'
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
      response(422, 'successful') do
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

  path '/api/v1/participants/change_handle/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    post('update_handle participant') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :check_this, in: :body, schema: {
        type: :object,
        properties:{
          participant: {type: :object}
        }
      }
      let(:id) {1}
      let(:old_handle) {'oldhandle'}
      let(:new_handle) { 'newhandle' }
      let(:assignment_participant) {instance_double(AssignmentParticipant)}
      let(:a_participant) {instance_double(Participant)}
      let(:participant) {{handle: old_handle}}
      let(:check_this) {{participant: participant}}

      before do
        allow(AssignmentParticipant).to receive(:find).with(id).and_return(assignment_participant)
        allow(assignment_participant).to receive(:handle).and_return(old_handle)

      end
      response(200, 'successful') do  
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, note: "Handle already in use")
            }
          }
        end
          run_test!
      end
    end
  end
  
  

  # path '/api/v1/participants/update_authorizations/{id}/{authorization}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :integer, description: 'id'
  #   parameter name: 'authorization', in: :path, type: :string, description: 'authorization'
  #   let(:id) { 1 }
  #   let(:authorization) { '123' }
  #   post('update_authorizations participant') do
  #     controller.send(:update_authorizations, id, authorization)
  #     response(200, 'successful') do

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

  path '/api/v1/participants/inherit/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    
    let(:id) {1}
    let(:an_assignment) {instance_double(Assignment)}
    let(:a_course) {instance_double(Course)}
    before do
      allow(Assignment).to receive(:find).and_return(an_assignment)
      allow(an_assignment).to receive(:course).and_return(nil)
    end

    get('inherit participant') do
      response(422, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: "No course was found for this assignment")
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/participants/bequeath/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    let(:id) { 1 }
    let(:an_assignment) {instance_double(Assignment)}
    let(:a_course) {instance_double(Course)}
    before do
      allow(Assignment).to receive(:find).and_return(an_assignment)
      allow(an_assignment).to receive(:course).and_return(nil)
    end
    get('bequeath participant') do
      response(422, 'successful') do
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
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    let(:id) { 1 }
    let(:a_participant) {instance_double(Participant)}
    let(:an_object) {instance_double(Object)}
    
    before do
      allow(Participant).to receive(:find).with(id).and_return(a_participant)
      allow(a_participant).to receive(:team).and_return(an_object)
      allow(an_object).to receive(:present?).and_return(false)
      allow(a_participant).to receive(:destroy).and_return(true)
      allow(a_participant).to receive_message_chain(:user, :name).and_return('John Doe')
    end

    delete('delete participant') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, message: "#{a_participant.user.name} was successfully removed as a participant")
            }
          }
        end
        run_test!
      end
    end
  end

end
