VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "support", "cassettes")
  c.hook_into :webmock

  c.register_request_matcher :uri_without_partition_id do |request1, request2|
    uri1 = request1.uri
    uri2 = request2.uri
    regexp_partition_id = %r(/\d+)

    if uri1.match(regexp_partition_id)
      r1_without_id = uri1.gsub(regexp_partition_id, "")
      r2_without_id = uri2.gsub(regexp_partition_id, "")
      uri2.match(regexp_partition_id) && r1_without_id == r2_without_id
    else
      uri1 == uri2
    end
  end
end
