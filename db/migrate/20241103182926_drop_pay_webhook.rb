class DropPayWebhook < ActiveRecord::Migration[7.2]
  def change
    drop_table :pay_webhooks
  end
end
