<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use App\Mail\RegistroCorreo;


class UserController extends Controller
{
    public function register(Request $request)
    {
        // Validar los datos del usuario
        $request->validate([
            'nom' => 'required|string|max:255',
            'cognoms' => 'required|string|max:255',
            'email' => 'required|string|email|unique:usuaris',
            'password' => 'required|string|min:8',
            'foto_perfil' => 'required|in:1,2,3,4,5,6,7,8,9'
        ]);
    
        // Crear un nuevo usuario
        $user = new User();
        $user->nom = $request->nom;
        $user->cognoms = $request->cognoms;
        $user->email = $request->email;
        $user->password = Hash::make($request->password); // Encriptar la contraseña
        $user->foto_perfil = $request->foto_perfil;
        $user->save();

        // Enviar un correo electrónico de bienvenida al usuario
        \Mail::to($user->email)->send(new RegistroCorreo($user));
        
    
        // Retornar una respuesta con los detalles del usuario y el token de acceso
        return response()->json([
            'user' => $user,
            
        ], 201);
    }
    
    public function login(Request $request)
{
    // Validar los datos del usuario
    $request->validate([
        'email' => 'required|string|email',
        'password' => 'required|string'
    ]);

    // Buscar el usuario en la base de datos
    $user = User::where('email', $request->email)->first();

    // Verificar si el usuario existe y las credenciales son correctas
    if (!$user || !Hash::check($request->password, $user->password)) {
        return response()->json([
            'message' => 'Credenciales incorrectas'
        ], 401);
    }

    // Obtener el token de acceso para el usuario
    $token = $user->createToken('auth_token')->plainTextToken;

    // Retornar una respuesta con los detalles del usuario y el token de acceso
    return response()->json([
        'user' => $user,
    ]);
}
    public function logout(Request $request)
    {
        // Revocar todos los tokens de autenticación del usuario
        $request->user()->tokens()->delete();

        // Retornar una respuesta apropiada
        return response()->json([
            'message' => 'Sesión cerrada exitosamente'
        ]);
    }
    public function mostrarUsuario($id)
{
    // Buscar el usuario por su ID
    $user = User::find($id);

    // Verificar si se encontró el usuario
    if (!$user) {
        return response()->json(['message' => 'Usuario no encontrado'], 404);
    }

    // Eliminar el campo de la contraseña antes de devolver la respuesta
    unset($user->password);

    // Devolver la información del usuario como JSON
    return response()->json($user);
}
public function modificarUsuario(Request $request, $id)
{
    $validator = Validator::make($request->all(), [
        'nom' => 'sometimes',
        'cognoms' => 'sometimes',
        'email' => 'sometimes|string|email|unique:usuaris,email,' . $id,
        'password' => 'sometimes',
        'foto_perfil' => 'sometimes|in:1,2,3,4,5,6,7,8,9'
    ]);

    if ($validator->fails()) {
        return response()->json([
            'errors' => $validator->errors()
        ], 422);
    }

    $user = User::find($id);
    if (!$user) {
        return response()->json([
            'message' => 'Usuario no encontrado'
        ], 404);
    }

    if ($request->has('nom')) {
        $user->nom = $request->nom;
    }
    if ($request->has('cognoms')) {
        $user->cognoms = $request->cognoms;
    }
    if ($request->has('email')) {
        $user->email = $request->email;
    }
    if ($request->has('password')) {
        $user->password = Hash::make($request->password);
    }
    if ($request->has('foto_perfil')) {
        $user->foto_perfil = $request->foto_perfil;
    }

    $user->save();

    return response()->json([
        'user' => $user
    ], 200);
}


}
