<?php

namespace App\Http\Livewire;

use App\Models\Banner;
use Livewire\Component;

class Dashboard extends Component
{
    public function render()
    {
        return view('livewire.dashboard', [
            'banners' => Banner::all(),
        ]);
    }
}
