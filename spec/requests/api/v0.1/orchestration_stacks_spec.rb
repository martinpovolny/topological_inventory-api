require_relative "shared_examples_for_index"

RSpec.describe("v0.1 - OrchestrationStack") do
  let(:source) { Source.create!(:name => "name", :source_type => source_type, :tenant => tenant) }
  let(:source_type) { SourceType.create!(:vendor => "vendor", :product_name => "product_name", :name => "name") }
  let(:tenant) { Tenant.find_or_create_by!(:name => "default", :external_tenant => "external_tenant_uuid")}

  let(:attributes) do
    {
      "source_id"            => source.id.to_s,
      "tenant_id"            => tenant.id.to_s,
      "source_ref"           => SecureRandom.uuid
    }
  end

  include_examples(
    "test_index_and_subcollections",
    "orchestration_stacks",
    [],
  )
end
