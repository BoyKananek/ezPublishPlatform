UPDATE ezsite_data SET value='5.4.0' WHERE name='ezpublish-version';

DROP TABLE ezsearch_return_count;
DROP SEQUENCE ezsearch_return_count_s;

UPDATE ezcontentobject_attribute
    SET data_int = NULL
WHERE
    data_int = 0
    AND data_type_string IN ( 'ezdate', 'ezdatetime' );

UPDATE ezinfocollection_attribute
SET data_int = NULL
FROM ezcontentclass_attribute
WHERE
    ezcontentclass_attribute.id = ezinfocollection_attribute.contentclass_attribute_id
    AND ezinfocollection_attribute.data_int = 0
    AND ezcontentclass_attribute.data_type_string IN ( 'ezdate', 'ezdatetime' );

-- See https://jira.ez.no/browse/EZP-23595 - cleanup extra lines in the ezuser_setting table
DELETE FROM ezuser_setting where user_id not in (SELECT contentobject_id FROM ezuser);
