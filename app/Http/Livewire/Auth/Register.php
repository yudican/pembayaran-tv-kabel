<?php

namespace App\Http\Livewire\Auth;

use App\Models\Team;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\Hash;
use Livewire\Component;
use Livewire\WithFileUploads;

class Register extends Component
{
    use WithFileUploads;

    public $name;
    public $email;
    public $password;
    public $password_confirmation;


    public function render()
    {
        return view('livewire.auth.register');
    }

    public function store()
    {
        // dd('ok');
        $rules = [
            'name' => 'required',
            'email' => 'required',
            'password' => 'required|min:8',
            'password_confirmation' => 'required|min:8|same:password',
        ];

        $this->validate($rules);

        $user = User::create([
            'name' => $this->name,
            'email' => $this->email,
            'password' => Hash::make($this->password)
        ]);

        $team = Team::find(1);
        $team->users()->attach($user, ['role' => 'member']);
        $user->roles()->attach('0feb7d3a-90c0-42b9-be3f-63757088cb9a');

        $this->_resetForm();
        event(new Registered($user));
        $this->emit('showAlert', [
            'msg' => 'Registrasi Berhasil, silahkan login.',
            'redirect' => true,
            'path' => 'login'
        ]);
    }

    public function _resetForm()
    {
        $this->name = null;
        $this->email = null;
        $this->password = null;
        $this->password_confirmation = null;
    }
}
