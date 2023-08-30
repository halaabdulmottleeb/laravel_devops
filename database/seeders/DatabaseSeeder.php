<?php

namespace Database\Seeders;

use App\Models\Tenant;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $tenant1 = Tenant::create(['id' => 'foo']);
        $tenant2 = Tenant::create(['id' => 'bar']);

        $tenant1->domains()->create(['domain' => 'foo.laravelproject.local']);
        $tenant2->domains()->create(['domain' => 'bar.laravelproject.local']);
    
    }
}
