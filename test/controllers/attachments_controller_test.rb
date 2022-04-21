require "test_helper"

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attachment = attachments(:one)
  end

  test "should get index" do
    get attachments_url
    assert_response :success
  end

  test "should get new" do
    get new_attachment_url
    assert_response :success
  end

  test "should create attachment" do
    assert_difference("Attachment.count") do
      post attachments_url, params: { attachment: { approval_status: @attachment.approval_status, approved_by_id: @attachment.approved_by_id, attached_by_id: @attachment.attached_by_id, company_id: @attachment.company_id, name: @attachment.name, phase_id: @attachment.phase_id, project_id: @attachment.project_id, step_id: @attachment.step_id } }
    end

    assert_redirected_to attachment_url(Attachment.last)
  end

  test "should show attachment" do
    get attachment_url(@attachment)
    assert_response :success
  end

  test "should get edit" do
    get edit_attachment_url(@attachment)
    assert_response :success
  end

  test "should update attachment" do
    patch attachment_url(@attachment), params: { attachment: { approval_status: @attachment.approval_status, approved_by_id: @attachment.approved_by_id, attached_by_id: @attachment.attached_by_id, company_id: @attachment.company_id, name: @attachment.name, phase_id: @attachment.phase_id, project_id: @attachment.project_id, step_id: @attachment.step_id } }
    assert_redirected_to attachment_url(@attachment)
  end

  test "should destroy attachment" do
    assert_difference("Attachment.count", -1) do
      delete attachment_url(@attachment)
    end

    assert_redirected_to attachments_url
  end
end
