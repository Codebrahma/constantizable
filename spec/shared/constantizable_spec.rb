require "spec_helper"

shared_examples "constantizable" do

  constantized_column = described_class.instance_variable_get(:@constantized_column)

  create_mock_record_with = -> (column_data) {
    described_class.new({ constantized_column => column_data })
  }

  context "##{constantized_column}" do
    it "returns a string" do
      record = create_mock_record_with.call("sample")
      described_class.stub(:find_by).and_return(record)
      expect(record.send(constantized_column)).to be_an_instance_of String
    end
  end
  
  context "#method_missing" do
    describe "returns the record with the called :#{constantized_column}" do

      it "when :#{constantized_column} contains single word" do
        record = create_mock_record_with.call("sample")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample).to eq record
      end

      it "when :#{constantized_column} contains more than 1 word without space" do
        record = create_mock_record_with.call("sample_name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name).to eq record
      end

      it "when :#{constantized_column} contains more than 1 word with space" do
        record = create_mock_record_with.call("sample name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name).to eq record
      end

      it "when :#{constantized_column} contains more than 1 word with space and upper case" do
        record = create_mock_record_with.call("Sample Name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name).to eq record
      end
    end
  end
end
