ActiveAdmin.register Gig do
    index do
        column :title
        column :description
        column :status
        column :worker_id
        column :employer_id
        column :created_at
        column :updated_at
        default_actions
    end

    

    form do |f|
        f.inputs "Gig Details" do
            f.input :title
            f.input :description
            f.input :status
        end
        f.buttons
    end

    show do
        attributes_table do
            row :title
            row :description
            row :status
            row :worker_id
            row :employer_id
            row :created_at
        end
        active_admin_comments
    end
end
