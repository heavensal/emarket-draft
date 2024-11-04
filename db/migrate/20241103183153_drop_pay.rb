class DropPay < ActiveRecord::Migration[7.2]
  def up
    # Suppression de la table avec CASCADE pour supprimer également tous les objets dépendants
    execute "DROP TABLE pay_payment_methods CASCADE;"
    execute "DROP TABLE pay_customers CASCADE;"
    execute "DROP TABLE pay_charges CASCADE;"
    execute "DROP TABLE pay_merchants CASCADE;"
  end
end
