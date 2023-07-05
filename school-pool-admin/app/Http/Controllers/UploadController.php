<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Imports\ContactsImport;
use Maatwebsite\Excel\Facades\Excel;

class UploadController extends Controller
{
    public function process_file(){
        $rows = Excel::toArray(new ContactsImport(), request()->file('contact_data'));
        print_r($rows);
    }

}
