require 'swagger_helper'
require 'spec_helper'
require 'rails_helper'

RSpec.describe 'api/v1/participants', type: :request do

  # test to check index with Assignment model and id
  path '/api/v1/participants/index/{model}/{id}' do
    # QUERY PARAMETERS
    parameter name: 'model', in: :path, type: :string, description: 'Assignment'
    parameter name: 'id', in: :path, type: :integer, description: 1

    # GET request to index method
    get('index participants') do
      # mocking of model and participant array to return array of participants
      let(:model) { 'Assignment' }
      let(:id) { 1 }
      let(:participants) {[instance_double(Participant)]}

      # stubbing methods in the mock objects
      before do
        assignment_instance = instance_double(Assignment)
        allow(Assignment).to receive(:find).with(id).and_return(assignment_instance)
        allow_any_instance_of(Assignment).to receive(:participants).and_return(participants)
        allow(assignment_instance).to receive(:participants).and_return(participants)
      end

      # successful response giving a list of (empty) participants of a given assignment
      response(200, 'successful') do   
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, model_object: "Assignment", participants:[])
            }
          }
        end
        run_test!
      end
    end
  end

  # test to check index with Course model and id
  path '/api/v1/participants/index/{model}/{id}' do
    # Query Parameters
    parameter name: 'model', in: :path, type: :string, description: 'Assignment'
    parameter name: 'id', in: :path, type: :integer, description: 1

    # GET Request to index method
    get('index participants') do
      # mocking models that are required
      let(:model) { 'Course' }
      let(:id) { 1 }
      let(:participants) {[instance_double(Participant)]}

      # stubbing methods that are required in the mock objects
      before do
        course_instance = instance_double(Course)
        allow(Course).to receive(:find).with(id).and_return(course_instance)
        allow_any_instance_of(Course).to receive(:participants).and_return(participants)
        allow(course_instance).to receive(:participants).and_return(participants)
      end

      # successful response which returns array of participants (empty) of the dpscified course
      response(200, 'successful') do   
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, model_object: "Course", participants:[])
            }
          }
        end
        run_test!
      end
    end
  end

  # test to check index with a non existent id
  path '/api/v1/participants/index/{model}/{id}' do
    # Query parameters
    parameter name: 'model', in: :path, type: :string
    parameter name: 'id', in: :path, type: :integer, description: 1

    # GET Request to index method
    get('index participants') do
      # mocking models that are required for the method call
      let(:model) { 'Course' }
      let(:id) { 1 }
      let(:participants) {[instance_double(Participant)]}

      # stubbing methods on mock objects
      before do
        course_instance = instance_double(Course)
        allow(Course).to receive(:find).with(1).and_return(nil)
        allow_any_instance_of(Course).to receive(:participants).and_return(participants)
        allow(course_instance).to receive(:participants).and_return(participants)
      end

      # error response due to non existent ID for Assignment/Course
      response(422, 'successful') do   
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: "Missing or invalid required parameters")
            }
          }
        end
        run_test!
      end
    end
  end

  # test to create a new participant
  path '/api/v1/participants/{model}/{id}/{authorization}' do
    # Query Parameters
    parameter name: 'model', in: :path, type: :string, description: 'model'
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

    # POST Request to create method
    post('create participant') do
      consumes 'application/json'
      produces 'application/json'

      # mocking adding request body parameters
      parameter name: :check_this, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object }
        }
      }

        # mocking models required for method execution
        let(:model) { 'Assignment' }
        let(:id) { 1 }
        let(:authorization) { '123' }
        let(:name) {"ABCD"}
        let(:check_this) { {user: {name: name}} }
        let(:a_user) { instance_double(User) }
        let(:assignment_instance) {instance_double(Assignment)}
        let(:a_participant) {instance_double(Participant)}
        let(:participants) {[a_participant]}

        # adding stubs to mock objects
        before do
          allow(a_user).to receive(:name).and_return(name)
          allow(a_user).to receive(:id).and_return(23)
          allow(assignment_instance).to receive(:id).and_return(1)
          allow(User).to receive(:find_by).with({name: name}).and_return(a_user)
          allow(Assignment).to receive(:find).with(id).and_return(assignment_instance)
          allow(assignment_instance).to receive(:participants).and_return(Participant)
          allow(Participant).to receive(:find_by).with({user_id: a_user.id}).and_return(a_participant)
          allow(a_participant).to receive(:present?).and_return(true)
          
        end

        # error response when creating erraneous participant
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

  # test to update handle of participant
  path '/api/v1/participants/change_handle/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    # POST Request to update_handle method
    post('update_handle participant') do
      consumes 'application/json'
      produces 'application/json'

      # mocking request body parameters
      parameter name: :check_this, in: :body, schema: {
        type: :object,
        properties:{
          participant: {type: :object}
        }
      }

      # mocking models required for method execution
      let(:id) {1}
      let(:old_handle) {'oldhandle'}
      let(:new_handle) { 'newhandle' }
      let(:assignment_participant) {instance_double(AssignmentParticipant)}
      let(:a_participant) {instance_double(Participant)}
      let(:participant) {{handle: old_handle}}
      let(:check_this) {{participant: participant}}

      # stubbing methods on mock objects
      before do
        allow(AssignmentParticipant).to receive(:find).with(id).and_return(assignment_participant)
        allow(assignment_participant).to receive(:handle).and_return(old_handle)

      end

      # sucessful response saying that handle already exists
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

 # test to update handle of participant
  path '/api/v1/participants/change_handle/{id}' do
    # Query Parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    # POST Request to update_handle method
    post('update_handle participant') do
      consumes 'application/json'
      produces 'application/json'

      # mocking request bidy params
      parameter name: :check_this, in: :body, schema: {
        type: :object,
        properties:{
          participant: {type: :object}
        }
      }

      # mocking models required for method execution
      let(:id) {1}
      let(:old_handle) {'oldhandle'}
      let(:new_handle) { 'newhandle' }
      let(:assignment_participant) {instance_double(AssignmentParticipant)}
      let(:a_participant) {instance_double(Participant)}
      let(:participant) {{handle: new_handle}}
      let(:check_this) {{participant: participant}}


      # stubbing methods on mock objects
      before do
        allow(AssignmentParticipant).to receive(:find).with(id).and_return(assignment_participant)
        allow(assignment_participant).to receive(:handle).and_return(old_handle)
        allow(assignment_participant).to receive(:update).and_return(false)
        allow(assignment_participant).to receive(:errors).and_return("Error")

      end

      # error response because the update method on participant model failed
      response(422, 'successful') do  
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: assignment_participant.errors)
            }
          }
        end
          run_test!
      end
    end
  end
  
  # test to update authorizations for a participant
  path '/api/v1/participants/update_authorizations/{id}/{authorization}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    parameter name: 'authorization', in: :path, type: :string, description: 'authorization'

    # mocking models required
    let(:id) { 1 }
    let(:authorization) { '123' }
    let(:a_participant) {instance_double(Participant)}

    # stubbing methods on mock objects
    before do
      allow(Participant).to receive(:find).with(id).and_return(a_participant)
      allow(a_participant).to receive(:update).and_return({:can_submit=>true, :can_review=>true, :can_take_quiz=>true})
    end

    # PATCH request to update_authorizations method of participant
    patch('update_authorizations participant') do

      # successful response after updating authorizations
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


  # test to update authorizations for a participant
  path '/api/v1/participants/update_authorizations/{id}/{authorization}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    parameter name: 'authorization', in: :path, type: :string, description: 'authorization'
    let(:id) { 1 }
    let(:authorization) { '123' }
    let(:a_participant) {instance_double(Participant)}

    before do
      allow(Participant).to receive(:find).with(id).and_return(a_participant)
      allow(a_participant).to receive(:update).and_return(false)
      allow(a_participant).to receive(:errors).and_return('Error')
    end
    patch('update_authorizations participant') do
      response(422, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: a_participant.errors)
            }
          }
        end
        run_test!
      end
    end
  end

  # test to "inherit" participants from Course to Assignment
  path '/api/v1/participants/inherit/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    
    # mocking models that are required for method execution
    let(:id) {1}
    let(:assignment_instance) {instance_double(Assignment)}
    let(:course_instance) {instance_double(Course)}

    # stubbing methods on mock objects
    before do
      allow(Assignment).to receive(:find).and_return(assignment_instance)
      allow(assignment_instance).to receive(:course).and_return(nil)
    end

    # GET Request to inherit method
    get('inherit participant') do

      # Error response for when assignment has no course
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


  # test to "inherit" participants from Course to Assignment
  path '/api/v1/participants/inherit/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    
    # Mocking models that are required
    let(:id) {1}
    let(:assignment_instance) {instance_double(Assignment)}
    let(:course_instance) {instance_double(Course)}

    # stubbing methods that are required for mock objects
    before do
      allow(Assignment).to receive(:find).and_return(assignment_instance)
      allow(assignment_instance).to receive(:course).and_return(course_instance)
      allow(course_instance).to receive(:participants).and_return([])
      allow(Course).to receive(:name).and_return("Course")
      allow(course_instance).to receive(:name).and_return("Course")
    end

    # GET Request to inherit method of participant controller
    get('inherit participant') do

      # successful response after "inheriting" participants from course to assignment
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, note: "No participants were found for this #{course_instance.name}")
            }
          }
        end
        run_test!
      end
    end
  end

  # test to "inherit" participants from Assignment to Course
  path '/api/v1/participants/bequeath/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    # Mocking models that are required
    let(:id) { 1 }
    let(:assignment_instance) {instance_double(Assignment)}
    let(:course_instance) {instance_double(Course)}

    # stubbing methods on mock objects
    before do
      allow(Assignment).to receive(:find).and_return(assignment_instance)
      allow(assignment_instance).to receive(:course).and_return(nil)
    end

    # GET request to bequeath methof
    get('bequeath participant') do
      # error response from when Course Has no such assignment
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

  # test to "inherit" participants from Assignment to Course
  path '/api/v1/participants/bequeath/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    # mocking objkects required for this method
    let(:id) { 1 }
    let(:assignment_instance) {instance_double(Assignment)}
    let(:course_instance) {instance_double(Course)}

    # stubbing methods for mock objects
    before do
      allow(Assignment).to receive(:find).and_return(assignment_instance)
      allow(assignment_instance).to receive(:course).and_return(course_instance)
      allow(assignment_instance).to receive(:participants).and_return([])
      allow(Course).to receive(:name).and_return("Course")
      allow(assignment_instance).to receive(:name).and_return("Assignment")
    end

    # GET Request to bequeath method
    get('bequeath participant') do
      # Successful response after copy completes
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, example: JSON.parse(response.body, note: "No participants were found for this #{assignment_instance.name}"))
            }
          }
        end
        run_test!
      end
    end
  end

  # test to destroy participants
  path '/api/v1/participants/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    # mocking objects required for this method call
    let(:id) { 1 }
    let(:a_participant) {instance_double(Participant)}
    let(:an_object) {instance_double(Object)}
    
    # stubbing methods to the mock objects
    before do
      allow(Participant).to receive(:find).with(id).and_return(a_participant)
      allow(a_participant).to receive(:team).and_return(an_object)
      allow(an_object).to receive(:present?).and_return(false)
      allow(a_participant).to receive(:destroy).and_return(true)
      allow(a_participant).to receive_message_chain(:user, :name).and_return('John Doe')
    end

    # DELETE Request to participant
    delete('delete participant') do
      # Successful response after delete is complete
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

  # test to destroy participants
  path '/api/v1/participants/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    # mocking objects/models for the method execution
    let(:id) { 1 }
    let(:a_participant) {instance_double(Participant)}
    let(:an_object) {instance_double(Object)}
    
    # stubbing methods to mock objects
    before do
      allow(Participant).to receive(:find).with(id).and_return(a_participant)
      allow(a_participant).to receive(:team).and_return(an_object)
      allow(an_object).to receive(:present?).and_return(false)
      allow(a_participant).to receive(:destroy).and_return(false)
      allow(a_participant).to receive_message_chain(:user, :name).and_return('John Doe')
    end

    # DELETE Request
    delete('delete participant') do
      # error response for when destroy participant does not work in participant model
      response(422, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: "Failed to remove participant")
            }
          }
        end
        run_test!
      end
    end
  end

  # test to destroy participants
  path '/api/v1/participants/{id}' do
    # Query parameters
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    # mocking objects/models required for this method
    let(:id) { 1 }
    let(:a_participant) {instance_double(Participant)}
    let(:an_object) {instance_double(Object)}
    
    # adding stubs to mock objects
    before do
      allow(Participant).to receive(:find).with(id).and_return(a_participant)
      allow(a_participant).to receive(:team).and_return(an_object)
      allow(an_object).to receive(:present?).and_return(true)
      allow(a_participant).to receive(:destroy).and_return(false)
      allow(a_participant).to receive_message_chain(:user, :name).and_return('John Doe')
    end

    # DELETE Request
    delete('delete participant') do

      # error response because participant is on a team and cannot be deleted
      response(422, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, error: "This participant is on a team")
            }
          }
        end
        run_test!
      end
    end
  end
end