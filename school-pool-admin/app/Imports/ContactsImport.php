<?php

namespace App\Imports;

use App\Models\parent_contact;
use Maatwebsite\Excel\Concerns\ToModel;

class ContactsImport implements ToModel
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        return new parent_contact([
            'phone_number' => $row[0]
        ]);
    }
}
