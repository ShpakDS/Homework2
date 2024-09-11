<?php

require 'vendor/autoload.php';

use Elasticsearch\ClientBuilder;
use MongoDB\Client;

try {
    (new Client("mongodb://mongodb:27017"))
        ->test->items
        ->insertOne(['name' => 'test_item', 'value' => rand(1, 50)]);

    (ClientBuilder::create()->setHosts(['localhost:9300'])->build())
        ->index(['index' => 'test_index', 'body' => ['testField' => 'abc']]);

    echo "Data inserted into MongoDB and Elasticsearch.";
} catch (Exception $e) {
    echo $e->getMessage();
}