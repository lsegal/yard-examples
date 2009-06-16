context "A blog post" do
  setup do
    @author = create_person
    @post   = create_post :author => @author
  end

  expect { @post.to be_editable_by(@author) }
  expect { @post.not_to be_editable_by(@somebody_else) }
end
