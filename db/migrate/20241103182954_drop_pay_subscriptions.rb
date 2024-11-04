class DropPaySubscriptions < ActiveRecord::Migration[7.2]
  def up
    # Suppression de la table avec CASCADE pour supprimer également tous les objets dépendants
    execute "DROP TABLE pay_subscriptions CASCADE;"
  end
end
