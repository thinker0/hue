# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):

        # Adding field 'QueryHistory.server_name'
        db.add_column('beeswax_queryhistory', 'server_name', self.gf('django.db.models.fields.CharField')(default='', max_length=128), keep_default=False)

        # Adding field 'QueryHistory.server_host'
        db.add_column('beeswax_queryhistory', 'server_host', self.gf('django.db.models.fields.CharField')(default='', max_length=128), keep_default=False)

        # Adding field 'QueryHistory.server_port'
        db.add_column('beeswax_queryhistory', 'server_port', self.gf('django.db.models.fields.SmallIntegerField')(default=0), keep_default=False)

        # Changing field 'QueryHistory.query'
        db.alter_column('beeswax_queryhistory', 'query', self.gf('django.db.models.fields.TextField')())


    def backwards(self, orm):

        # Deleting field 'QueryHistory.server_name'
        db.delete_column('beeswax_queryhistory', 'server_name')

        # Deleting field 'QueryHistory.server_host'
        db.delete_column('beeswax_queryhistory', 'server_host')

        # Deleting field 'QueryHistory.server_port'
        db.delete_column('beeswax_queryhistory', 'server_port')

        # Changing field 'QueryHistory.query'
        db.alter_column('beeswax_queryhistory', 'query', self.gf('django.db.models.fields.CharField')(max_length=1024))


    models = {
        'auth.group': {
            'Meta': {'object_name': 'Group'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        'auth.permission': {
            'Meta': {'unique_together': "(('content_type', 'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'blank': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'blank': 'True'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'blank': 'True'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        'beeswax.metainstall': {
            'Meta': {'object_name': 'MetaInstall'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'installed_example': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'blank': 'True'})
        },
        'beeswax.queryhistory': {
            'Meta': {'object_name': 'QueryHistory'},
            'design': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['beeswax.SavedQuery']", 'null': 'True'}),
            'has_results': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'last_state': ('django.db.models.fields.IntegerField', [], {'db_index': 'True'}),
            'log_context': ('django.db.models.fields.CharField', [], {'max_length': '1024', 'null': 'True'}),
            'notify': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'blank': 'True'}),
            'owner': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"}),
            'query': ('django.db.models.fields.TextField', [], {}),
            'server_host': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '128'}),
            'server_id': ('django.db.models.fields.CharField', [], {'max_length': '1024', 'null': 'True'}),
            'server_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '128'}),
            'server_port': ('django.db.models.fields.SmallIntegerField', [], {'default': "''"}),
            'submission_date': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'})
        },
        'beeswax.savedquery': {
            'Meta': {'object_name': 'SavedQuery'},
            'data': ('django.db.models.fields.TextField', [], {'max_length': '65536'}),
            'desc': ('django.db.models.fields.TextField', [], {'max_length': '1024'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_auto': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'db_index': 'True', 'blank': 'True'}),
            'mtime': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '64'}),
            'owner': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"}),
            'type': ('django.db.models.fields.IntegerField', [], {})
        },
        'contenttypes.contenttype': {
            'Meta': {'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        }
    }

    complete_apps = ['beeswax']
