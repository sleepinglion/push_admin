class CreateFaqs < ActiveRecord::Migration
    def change
        create_table :faq_categories do |t|
            t.integer :faqs_count, null: false, default: 0
            t.boolean :enable, null: false, default: true
            t.timestamps null: false
        end

        create_table :faqs do |t|
            t.references :faq_category, null: false
            t.integer :count, default: 0, null: false
            t.boolean :enable, null: false, default: true
            t.timestamps null: false
        end

        create_table :faq_contents do |t|
            t.timestamps null: false
        end

        add_index :faqs, :faq_category_id

        reversible do |dir|
            dir.up do
                FaqCategory.create_translation_table! title: :string
                Faq.create_translation_table! title: :string
                FaqContent.create_translation_table! content: :text
            end

            dir.down do
                Faq.drop_translation_table!
            end
        end
    end
end
