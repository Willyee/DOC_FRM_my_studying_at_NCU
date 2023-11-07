#pragma once
#include <math.h>
#include <stdio.h>
#include "data_format.h"

profile tank_profile;
enemy_profile obs;
int system_counter = 0;
float dt = 0.1;

namespace CppCLRWinFormsProject
{

    using namespace System;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;

    /// <summary>
    /// Summary for Form1
    /// </summary>
    public
    ref class Form1 : public System::Windows::Forms::Form
    {
    public:
        Form1(void)
        {
            InitializeComponent();
            //
            // TODO: Add the constructor code here
            //
        }

    protected:
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        ~Form1()
        {
            if (components)
            {
                delete components;
            }
        }

    private:
        System::Windows::Forms::Button^ button1;

    protected:
    private:
        System::Windows::Forms::Button^ button2;

    private:
        System::Windows::Forms::Button^ button3;

    private:
        System::Windows::Forms::Button^ button4;

    private:
        System::Windows::Forms::Button^ button5;

    private:
        System::Windows::Forms::Timer^ timer1;

    private:
        System::ComponentModel::IContainer^ components;

    private:
        /// <summary>
        /// Required designer variable.
        /// </summary>

#pragma region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        void InitializeComponent(void)
        {
            this->components = (gcnew System::ComponentModel::Container());
            this->button1 = (gcnew System::Windows::Forms::Button());
            this->button2 = (gcnew System::Windows::Forms::Button());
            this->button3 = (gcnew System::Windows::Forms::Button());
            this->button4 = (gcnew System::Windows::Forms::Button());
            this->button5 = (gcnew System::Windows::Forms::Button());
            this->timer1 = (gcnew System::Windows::Forms::Timer(this->components));
            this->SuspendLayout();
            //
            // button1
            //
            this->button1->Location = System::Drawing::Point(816, 12);
            this->button1->Name = L"button1";
            this->button1->Size = System::Drawing::Size(75, 23);
            this->button1->TabIndex = 0;
            this->button1->Text = L"F";
            this->button1->UseVisualStyleBackColor = true;
            this->button1->Click += gcnew System::EventHandler(this, &Form1::button1_Click);
            //
            // button2
            //
            this->button2->Location = System::Drawing::Point(897, 41);
            this->button2->Name = L"button2";
            this->button2->Size = System::Drawing::Size(75, 23);
            this->button2->TabIndex = 1;
            this->button2->Text = L"R";
            this->button2->UseVisualStyleBackColor = true;
            this->button2->Click += gcnew System::EventHandler(this, &Form1::button2_Click);
            //
            // button3
            //
            this->button3->Location = System::Drawing::Point(816, 70);
            this->button3->Name = L"button3";
            this->button3->Size = System::Drawing::Size(75, 23);
            this->button3->TabIndex = 2;
            this->button3->Text = L"B";
            this->button3->UseVisualStyleBackColor = true;
            this->button3->Click += gcnew System::EventHandler(this, &Form1::button3_Click);
            //
            // button4
            //
            this->button4->Location = System::Drawing::Point(816, 41);
            this->button4->Name = L"button4";
            this->button4->Size = System::Drawing::Size(75, 23);
            this->button4->TabIndex = 3;
            this->button4->Text = L"S";
            this->button4->UseVisualStyleBackColor = true;
            this->button4->Click += gcnew System::EventHandler(this, &Form1::button4_Click);
            //
            // button5
            //
            this->button5->Location = System::Drawing::Point(735, 41);
            this->button5->Name = L"button5";
            this->button5->Size = System::Drawing::Size(75, 23);
            this->button5->TabIndex = 4;
            this->button5->Text = L"L";
            this->button5->UseVisualStyleBackColor = true;
            this->button5->Click += gcnew System::EventHandler(this, &Form1::button5_Click);
            //
            // timer1
            //
            this->timer1->Enabled = true;
            this->timer1->Tick += gcnew System::EventHandler(this, &Form1::timer1_Tick);
            //
            // Form1
            //
            this->AutoScaleDimensions = System::Drawing::SizeF(6, 12);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(984, 961);
            this->Controls->Add(this->button5);
            this->Controls->Add(this->button4);
            this->Controls->Add(this->button3);
            this->Controls->Add(this->button2);
            this->Controls->Add(this->button1);
            this->Name = L"Form1";
            this->Text = L"Form1";
            this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
            this->ResumeLayout(false);
        }
#pragma endregion
        // 1 -> F
        // 2 -> R
        // 3 -> B
        // 4 -> S
        // 5 -> L
    private:
        System::Void timer1_Tick(System::Object^ sender, System::EventArgs^ e)
        {
            Motion_model();
            plot_HMI();
            system_counter++;
        }

    private:
        System::Void button1_Click(System::Object^ sender, System::EventArgs^ e)
        {
            tank_profile.vel.lin = 5 * 5;
        }

    private:
        System::Void button2_Click(System::Object^ sender, System::EventArgs^ e)
        {
        }

    private:
        System::Void button3_Click(System::Object^ sender, System::EventArgs^ e)
        {
        }

    private:
        System::Void button4_Click(System::Object^ sender, System::EventArgs^ e)
        {
        }

    private:
        System::Void button5_Click(System::Object^ sender, System::EventArgs^ e)
        {
        }
    void Motion_model(void)
    {
        tank_profile.pos.x = tank_profile.pos.x + dt * cos(tank_profile.pos.theta) * tank_profile.vel.lin;
        // X = X + dt * cos(Theta) * V;

        tank_profile.pos.y = tank_profile.pos.y + dt * sin(tank_profile.pos.theta) * tank_profile.vel.lin;
        // Y = Y + dt * sin(Theta) * V;

        tank_profile.pos.theta = tank_profile.pos.theta + dt * tank_profile.vel.ang;
        // Theta = Theta + dt * W;

        obs.pos.x = obs.pos.x + dt * 35;
        obs.pos.y = obs.pos.y + dt * 35;
        obs.pos.x = int(obs.pos.x) % 300;
        obs.pos.y = int(obs.pos.y) % 300;
    }

    void plot_HMI(void)
    {
        Graphics^ e1 = this->CreateGraphics();
        e1->Clear(Color::WhiteSmoke);
        Pen^ pen_B = gcnew Pen(Color::Blue, 2);
        Pen^ pen_K = gcnew Pen(Color::Black, 1);
        int R_size = 20;
        int grid_width = 400;
        int grid_height = 400;
        int shift_x = (grid_width / 2);
        int shift_y = (grid_height);
        // plot robot position
        int x1 = tank_profile.pos.x;
        int y1 = tank_profile.pos.y;
        e1->DrawEllipse(pen_B,
                        shift_x + x1 - R_size / 2,
                        shift_y - y1 - R_size / 2,
                        R_size,
                        R_size);
        int dir_x = 15 * cos(tank_profile.pos.theta);
        int dir_y = 15 * sin(tank_profile.pos.theta);
        e1->DrawLine(pen_B,
                     shift_x + x1,
                     shift_y - y1,
                     shift_x + x1 + dir_x,
                     shift_y - y1 - dir_y);
        x1 = obs.pos.x;
        y1 = obs.pos.y;
        e1->DrawRectangle(pen_K,
                          shift_x + x1 - R_size / 2,
                          shift_y - y1 - R_size / 2,
                          20,
                          20);
    }

    private:
        System::Void Form1_Load(System::Object^ sender, System::EventArgs^ e)
        {
        }
    };
}
