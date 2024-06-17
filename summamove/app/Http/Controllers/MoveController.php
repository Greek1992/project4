<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Achievements;
use App\Models\Exercises;
use App\Models\User;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Log;

class MoveController extends Controller
{
    public function index()
    {
        $client = new Client();
        $response = $client->request('GET', 'http://localhost:8000/api/items');
        $items = json_decode($response->getBody()->getContents());

        return view('items.index', compact('items'));
    }

    public function Achievementindex(Request $request)
    {
        $data = Achievements::all();
        return $data;

        Log::info('achievements index',['ip' => $request->ip(),'data' => $request->all()]);

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }
    public function Achievementid(Request $request, $id)
    {
        $data = Achievements::where('id',$id)->get();
        return $data;

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }
    public function Achievementexercise(Request $request, $id)
    {
        $data = Achievements::join('exercises', 'achievements.exerciseID', '=', 'exercises.id')->where('achievements.exerciseID', $id)->get();
        return $data;

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }
    public function Achievementuser(Request $request, $id)
    {
        $data = Achievements::join('users', 'achievements.userID', '=', 'users.id')->where('achievements.userID', $id)->get();
        return $data;

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }

    public function Exerciseindex(Request $request)
    {
        $data = Exercises::all();
        return $data;

        Log::info('exercises index',['ip' => $request->ip(),'data' => $request->all()]);

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }
    public function Exerciseid(Request $request, $id)
    {
        $data = Exercises::where('id',$id)->get();
        return $data;

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }

    public function Userindex(Request $request)
    {
        $data = User::all();
        return $data;

        Log::info('users index',['ip' => $request->ip(),'data' => $request->all()]);

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }
    public function Userid(Request $request, $id)
    {
        $data = User::where('id',$id)->get();
        return $data;

        $content = ['success' => true,'data' => $data,];
        return response()->json($content, 200);
    }

    public function Achievementtoevoegen(Request $request)
    {
        // Validate the request
        $validatedData = $request->validate([
            'exerciseID' => 'required|integer',
            'userID' => 'required|integer',
            'datum' => 'required|date',
            'amount' => 'required|integer',
        ]);

        try
        {
            // Create the reservation
            $achievement = Achievements::create([
                'exerciseID' => $validatedData['exerciseID'],
                'userID' => $validatedData['userID'],
                'datum' => $validatedData['datum'],
                'amount' => $validatedData['amount'],
            ]);

            // Log the request
            Log::info('achievement store', [
                'ip' => $request->ip(),
                'data' => $request->all(),
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'data' => $achievement,
            ], 201);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("Achievement toevoegen Fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Data niet correct',
                'error' => $e->getMessage(),
            ], 400);
        }
    }
    public function updateAchievement(Request $request, $id)
    {
        // Validate the request
        $validatedData = $request->validate([
            'exerciseID' => 'required|integer',
            'userID' => 'required|integer',
            'datum' => 'required|date',
            'amount' => 'required|integer',
        ]);

        try
        {
            // Find the reservation by ID
            $achievement = Achievements::findOrFail($id);

            // Update the reservation details
            $achievement->update([
                'exerciseID' => $validatedData['exerciseID'],
                'userID' => $validatedData['userID'],
                'datum' => $validatedData['datum'],
                'amount' => $validatedData['amount'],
            ]);

            // Log the request
            Log::info('achievement update', [
                'ip' => $request->ip(),
                'data' => $request->all(),
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'data' => $achievement,
            ], 200);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("Achievement bijwerken Fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Data niet correct',
                'error' => $e->getMessage(),
            ], 400);
        }
    }
    public function deleteAchievement(Request $request, $id)
    {
        try
        {
            // Find the reservation by ID
            $achievement = Achievements::findOrFail($id);

            // Delete the reservation
            $achievement->delete();

            // Log the request
            Log::info('achievement deleted', [
                'ip' => $request->ip(),
                'id' => $id,
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'message' => 'Achievement succesvol verwijderd',
            ], 200);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("Achievement verwijderen fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Er is een fout opgetreden bij het verwijderen van de achievement',
                'error' => $e->getMessage(),
            ], 400);
        }
    }

    public function Exercisetoevoegen(Request $request)
    {
        // Validate the request
        $validatedData = $request->validate([
            'name' => 'required|string',
            'instructionEN' => 'required|string',
            'instructieNL' => 'required|string',
        ]);

        try
        {
            // Create the reservation
            $exercise = Exercises::create([
                'name' => $validatedData['name'],
                'instructionEN' => $validatedData['instructionEN'],
                'instructieNL' => $validatedData['instructieNL'],
            ]);

            // Log the request
            Log::info('exercise store', [
                'ip' => $request->ip(),
                'data' => $request->all(),
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'data' => $exercise,
            ], 201);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("Exercise toevoegen Fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Data niet correct',
                'error' => $e->getMessage(),
            ], 400);
        }
    }
    public function updateExercise(Request $request, $id)
    {
        // Validate the request
        $validatedData = $request->validate([
            'name' => 'required|string',
            'instructionEN' => 'required|string',
            'instructieNL' => 'required|string',
        ]);

        try
        {
            // Find the reservation by ID
            $exercise = Exercises::findOrFail($id);

            // Update the reservation details
            $exercise->update([
                'name' => $validatedData['name'],
                'instructionEN' => $validatedData['instructionEN'],
                'instructieNL' => $validatedData['instructieNL'],
            ]);

            // Log the request
            Log::info('exercise update', [
                'ip' => $request->ip(),
                'data' => $request->all(),
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'data' => $exercise,
            ], 200);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("Exercise bijwerken Fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Data niet correct',
                'error' => $e->getMessage(),
            ], 400);
        }
    }
    public function deleteExercise(Request $request, $id)
    {
        try
        {
            // Find the reservation by ID
            $execrise = Exercises::findOrFail($id);

            // Delete the reservation
            $execrise->delete();

            // Log the request
            Log::info('execrise deleted', [
                'ip' => $request->ip(),
                'id' => $id,
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'message' => 'execrise succesvol verwijderd',
            ], 200);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("execrise verwijderen fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Er is een fout opgetreden bij het verwijderen van de execrise',
                'error' => $e->getMessage(),
            ], 400);
        }
    }

    public function deleteUser(Request $request, $id)
    {
        try
        {
            // Find the reservation by ID
            $user = User::findOrFail($id);

            // Delete the reservation
            $user->delete();

            // Log the request
            Log::info('user deleted', [
                'ip' => $request->ip(),
                'id' => $id,
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'message' => 'user succesvol verwijderd',
            ], 200);

        }
        catch (\Exception $e)
        {
            // Log the error
            Log::error("user verwijderen fout", ['exception' => $e]);

            // Return error response
            return response()->json([
                'success' => false,
                'message' => 'Er is een fout opgetreden bij het verwijderen van de user',
                'error' => $e->getMessage(),
            ], 400);
        }
    }
}
